/**

 @Name: Fly社区主入口

 */


layui.use(['layer', 'laytpl', 'form', 'element', 'upload', 'util', 'carousel', 'table', 'layedit', 'flow'], function (exports) {

    var $ = layui.jquery
        , layer = layui.layer
        , laytpl = layui.laytpl
        , form = layui.form
        , element = layui.element
        , upload = layui.upload
        , carousel = layui.carousel
        , util = layui.util
        , table = layui.table
        , device = layui.device()
        , flow = layui.flow
        , DISABLED = 'layui-btn-disabled';

    //阻止IE7以下访问
    if (device.ie && device.ie < 8) {
        layer.alert('如果您非得使用 IE 浏览器访问 iVusic 音乐网，那么请使用 IE8+');
    }

    flow.lazyimg();

    layui.focusInsert = function (obj, str) {
        var result, val = obj.value;
        obj.focus();
        if (document.selection) { //ie
            result = document.selection.createRange();
            document.selection.empty();
            result.text = str;
        } else {
            result = [val.substring(0, obj.selectionStart), str, val.substr(obj.selectionEnd)];
            obj.focus();
            obj.value = result.join('');
        }
    };


    //数字前置补零
    layui.laytpl.digit = function (num, length, end) {
        var str = '';
        num = String(num);
        length = length || 2;
        for (var i = num.length; i < length; i++) {
            str += '0';
        }
        return num < Math.pow(10, length) ? str + (num | 0) : num;
    };

    var fly = {
        //Ajax
        json: function (url, data, success, options) {
            var that = this, type = typeof data === 'function';

            if (type) {
                options = success
                success = data;
                data = {};
            }

            options = options || {};

            return $.ajax({
                type: options.type || 'post',
                dataType: options.dataType || 'json',
                data: data,
                url: url,
                success: function (res) {
                    if (res.code === 0) {
                        success && success(res);
                    } else {
                        layer.msg(res.msg || res.code, {shift: 6});
                        options.error && options.error();
                    }
                }, error: function (e) {
                    layer.msg('请求异常，请重试', {shift: 6});
                    options.error && options.error(e);
                }
            });
        }

        //计算字符长度
        , charLen: function (val) {
            var arr = val.split(''), len = 0;
            for (var i = 0; i < val.length; i++) {
                arr[i].charCodeAt(0) < 299 ? len++ : len += 2;
            }
            return len;
        }

        , form: {}

        , escape: function (html) {
            return String(html || '').replace(/&(?!#?[a-zA-Z0-9]+;)/g, '&amp;')
                .replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/'/g, '&#39;').replace(/"/g, '&quot;');
        }

        //内容转义
        , content: function (content) {
            //支持的html标签
            var html = function (end) {
                return new RegExp('\\n*\\[' + (end || '') + '(pre|hr|div|span|p|table|thead|th|tbody|tr|td|ul|li|ol|li|dl|dt|dd|h2|h3|h4|h5)([\\s\\S]*?)\\]\\n*', 'g');
            };
            content = fly.escape(content || '') //XSS
                .replace(/img\[([^\s]+?)\]/g, function (img) {  //转义图片
                    return '<img src="' + img.replace(/(^img\[)|(\]$)/g, '') + '">';
                }).replace(/@(\S+)(\s+?|$)/g, '@<a href="javascript:;" class="fly-aite">$1</a>$2') //转义@
                .replace(/face\[([^\s\[\]]+?)\]/g, function (face) {  //转义表情
                    var alt = face.replace(/^face/g, '');
                    return '<img alt="' + alt + '" title="' + alt + '" src="' + fly.faces[alt] + '">';
                }).replace(/a\([\s\S]+?\)\[[\s\S]*?\]/g, function (str) { //转义链接
                    var href = (str.match(/a\(([\s\S]+?)\)\[/) || [])[1];
                    var text = (str.match(/\)\[([\s\S]*?)\]/) || [])[1];
                    if (!href) return str;
                    var rel = /^(http(s)*:\/\/)\b(?!(\w+\.)*(sentsin.com|layui.com))\b/.test(href.replace(/\s/g, ''));
                    return '<a href="' + href + '" target="_blank"' + (rel ? ' rel="nofollow"' : '') + '>' + (text || href) + '</a>';
                }).replace(html(), '\<$1 $2\>').replace(html('/'), '\</$1\>') //转移HTML代码
                .replace(/\n/g, '<br>') //转义换行
            return content;
        }

        //新消息通知
        , userMsg: function () {
            var elemUser = $('.fly-nav-user');
            if (layui.cache.user.uid !== -1 && elemUser[0]) {
                fly.json('/index/index/message/', {_: new Date().getTime()
                }, function (res) {
                    if (res.code === 0 && res.count > 0) {
                        var msg = $('<a class="fly-nav-msg" href="javascript:;">' + res.count + '</a>');
                        elemUser.append(msg);
                        msg.on('click', function () {
                            fly.json('/message/read', {}, function (res) {
                                if (res.status === 0) {
                                    location.href = '/user/message/';
                                }
                            });
                        });
                        layer.tips('你有 ' + res.count + ' 条未读消息', msg, {
                            tips: 3
                            , tipsMore: true
                            , fixed: true
                        });
                        msg.on('mouseenter', function () {
                            layer.closeAll('tips');
                        })
                    }
                });
            }
            return arguments.callee;
        }

    };

    //新消息通知
    // fly.userMsg();

    //点击@
    $('body').on('click', '.fly-aite', function () {
        var othis = $(this), text = othis.text();
        if (othis.attr('href') !== 'javascript:;') {
            return;
        }
        text = text.replace(/^@|（[\s\S]+?）/g, '');
        othis.attr({
            href: '/jump?username=' + text
            , target: '_blank'
        });
    });

    //表单提交
    form.on('submit(*)', function (data) {
        var action = $(data.form).attr('action'), button = $(data.elem);
        fly.json(action, data.field, function (res) {
            var end = function () {
                if (res.url) {
                    location.href = res.action;
                } else {
                    fly.form[action || button.attr('key')](data.field, data.form);
                }
            };
            if (res.code == 0) {
                layer.msg(res.msg, {icon:1,shade:0.7,time:1000});
                // button.attr('alert') ? layer.alert(res.msg, {icon: 1, time: 10 * 1000, end: end}) : end();
            };
        });
        return false;
    });

    //加载特定模块
    if (layui.cache.page && layui.cache.page !== 'index') {
        var extend = {};
        extend[layui.cache.page] = layui.cache.page;
        layui.extend(extend);
        layui.use(layui.cache.page);
    }

    //手机设备的简单适配
    var treeMobile = $('.site-tree-mobile')
        , shadeMobile = $('.site-mobile-shade')

    treeMobile.on('click', function () {
        $('body').addClass('site-mobile');
    });

    shadeMobile.on('click', function () {
        $('body').removeClass('site-mobile');
    });


    /* 全局使用 **********************************************************************/

    //显示当前tab
    if (window.location.hash) {
        element.tabChange('user', window.location.hash.replace(/^#/, ''));
    }
    element.on('tab(user)', function () {
        var that = $(this), layId = that.attr('lay-id');
        if (layId) {
            window.location.hash = layId;
        }
    });

    //固定Bar
    util.fixbar({
        bgcolor: 'rgb(57, 57, 57)'
        ,showHeight: 400
        , css: {right: 10, bottom: 100}
    });


    var active = {
        //首页banner
        banner: function () {
            carousel.render({
                elem: '#indexCarouse'
                , width: '100%' //设置容器宽度
                , height: '355px' //设置容器宽度
                , arrow: 'always' //始终显示箭头
                //,anim: 'updown' //切换动画方式
            });
        },
        //详情banner
        bannerAbout: function () {
            var height = 590, setHeight = function(){
                var width = $(window).width();
                return (width > 1395 ? height : (width - 30)*height/1395) + 'px';
            }, inst1 = carousel.render({
                elem: '#LAY_preview'
                ,width: '100%'
                ,height: setHeight()
                ,anim: 'fade'
            });
        },
        setThisPlay: function () {
            $('.SMPlay').on("click", function () {
                var $id = $(this).data("id");
                if(!$id){
                    layer.tips("播放出错啦.", $(this).parent(), {tips:1});
                    return false;
                }
                myPlaylist.playThisMusic($id);
                /*$.post("/index/music/viewAdd",{id: $id}); //增加播放次数*/
               // layer.tips("当前播放歌曲：" + $musicname, $(this).parent(), {tips:1})
            })
        },
        collect: function ($id, $mid, $this) {
            if(!$id){layer.msg("哎呀，什么也没有呢！");return false;}
            var option = {
                url: app.config.baseUrl+"/title/title_addLike.do",
                dataType: "json",
                type: "post",
                data: {id: $id},
                success:function (res) {
                    var number = parseInt($("#setLove .heart-no").text());
                    if(res.code == 1){
                        $("#setLove").addClass("loved");
                        $("#setLove .heart-text").text('取消');
                        number += 1;
                        $("#setLove .heart-no").text(number)
                    }else if(res.code == 2){
                        $("#setLove").removeClass("loved");
                        $("#setLove .heart-text").text('喜欢');
                        if(number <= 0) return false;
                        number -= 1;
                        $("#setLove .heart-no").text(number)
                    }else{
                        $.niftyNoty({type: 'warning', message : res.msg, container : 'floating', timer : 3000});
                    }
                    return false;
                },
                error:function () {
                    layer.msg("服务器发生错误啦，请稍后再试！",{icon:5});
                    return false;
                }
            };
            $.ajax(option);
        },
        love: function () {
            /* 点击喜欢 */
            $("#setLove").on('click', function () {
                var $id = $(this).attr("data-id");
                var $mid = $(this).attr("data-mid");
                active.collect($id, $mid,this);
            })
        },
        comment: function () {
            /* 专辑-专题-小纸条留言接口 */
            $("#setComment").on('click', function () {
                var that = this;
                var $id = $(this).attr('data-id');
                var $mid = $(this).attr('data-mid');
                var $content = $($(this).attr('data-elem')).val();
                var $file = $($(this).attr('data-file')).val();
                var $username = $($(this).attr('data-userId')).val();
                var $musicname = $($(this).attr('data-musicname')).val();
                if(!$content || $content == undefined){
                    layer.tips("起码得说些什么吧.", this);
                    return false;
                }
                if(!$id || !$mid){
                    layer.tips("出错啦，稍后再来留下足迹吧.", this);
                    return false;
                }
                $.post( app.config.baseUrl+"/musicInfo/musicInfo_add4huifu.do", {musicname:$musicname,id: $id, content: $content, remark: $mid, img : $file, username: $username}, function (data) {
                	var $data = JSON.parse(data);
                	if($data.data.datetimestr == "1"){
                            var $html = '<li class="comment even thread-even depth-1"> ' +
                                '<div class="comment-body"> ' +
                                '<div class="comment-author vcard"> ' +
                                '<a target="_blank" title="" href="/index/user/index/id/'+ $data.data.id +'.html"> ' +
                                '<img src="'+app.config.baseUrl+"/attachment/"+$data.data.img +'" class="avatar" alt="'+ $data.data.pinglunname +'" width="44" height="44"> ' +
                                '</a> </div> ' +
                                '<div class="comment-main"> <p>'+ $content +'</p> ' +
                                '<div class="comment-meta"> <span class="author"><cite>'+ $data.data.pinglunname +'</cite></span> ' +
                                '<span class="date">'+ $data.data.date +'</span> </div> </div> <div class="comment-floor">'+ $data.data.last +'楼</div> </div> </li>';
                            $('.comment-list').append($html)
                            $(".comments-title").find("strong").html($data.data.last)
                            $("#pinglunshu").text($data.data.last)
                            $($(that).attr('data-elem')).val('');
                            layer.tips($data.msg, $('.comment-list li:last-child'), {tips:1});
                            $(document).pjax('#comments a', '#container', {fragment:'#container', timeout:8000});
                            return false;
                    }else{
                        layer.tips(data.msg, that);
                        return false;
                    }
                })
            });
            
            
            
            $("#BBSComment").on('click', function () {
                var that = this;
                var $id = $(this).attr('data-id');
                var $content = $($(this).attr('data-elem')).val();
                var $username = $($(this).attr('data-userId')).val();
                var $musicname = $($(this).attr('data-musicname')).val();
                if(!$content || $content == undefined){
                    layer.tips("起码得说些什么吧.", this);
                    return false;
                }
                if(!$id ){
                    layer.tips("出错啦，稍后再来留下足迹吧.", this);
                    return false;
                }
                $.post( app.config.baseUrl+"/title/title_huifu.do", {id: $id, content: $content}, function (data) {
                	var $data = JSON.parse(data);
                	if($data.code == "1"){
                            var $html = '<li class="comment even thread-even depth-1"> ' +
                                '<div class="comment-body"> ' +
                                '<div class="comment-author vcard"> ' +
                                '<a target="_blank" title="" href="/index/user/index/id/'+ $data.data.id +'.html"> ' +
                                '<img src="'+app.config.baseUrl+"/attachment/"+$data.data.img +'" class="avatar" alt="'+ $data.data.username +'" width="44" height="44"> ' +
                                '</a> </div> ' +
                                '<div class="comment-main"> <p>'+ $data.data.content +'</p> ' +
                                '<div class="comment-meta"> <span class="author"><cite>'+ $data.data.username +'</cite></span> ' +
                                '<span class="date">'+ $data.data.datetime +'</span> </div> </div> <div class="comment-floor">'+ $data.data.last +'楼</div> </div> </li>';
                            $('.comment-list').append($html)
                            $(".comments-title").find("strong").html($data.data.last)
                            $("#pinglunshu").text($data.data.last)
                            $("#comment2").text($data.data.last+"条评论")
                            $($(that).attr('data-elem')).val('');
                            layer.tips($data.msg, $('.comment-list li:last-child'), {tips:1});
                            $(document).pjax('#comments a', '#container', {fragment:'#container', timeout:8000});
                            return false;
                    }else{
                        layer.tips($data.msg, that);
                        return false;
                    }
                })
            })
            
        },
        collMusic: function ($id, $mid, $this) {
            if(!$id){layer.msg("哎呀，什么也没有选中呢！");return false;}
            $this = $($this);
            var option = {
                url: app.config.baseUrl+"/musicInfo/musicInfo_shoucang.do",
                dataType: "json",
                type: "post",
                data: {id:$id},
                success:function (data) {
                	
                    if(data.code == 200){
                        $this.toggleClass('active');
                        $.niftyNoty({ message : data.msg, container : 'floating', timer : 3000});
                        setTimeout(function(){  //使用  setTimeout（）方法设定定时2000毫秒
                        	window.location.reload();//页面刷新
                        	},1000);
                       
                    }else{
                        $.niftyNoty({type: 'warning',message : data.msg, container : 'floating', timer : 3000});
                        setTimeout(function(){  //使用  setTimeout（）方法设定定时2000毫秒
                        	window.location.reload();//页面刷新
                        	},1000);
                    }
                    return false;
                },
                error:function () {
                    layer.msg("服务器发生错误啦，请稍后再试！",{icon:5});
                    return false;
                }
            };
            $.ajax(option);
        }
        ,collectMusic: function () {
            var that = this;
            $(".collectThis").on("click", function () {
                var $id = $(this).attr("data-id");
                var $mid = $(this).attr("data-mid");
                that.collMusic($id, $mid, $(this));
            })
        },
        zan: function ($id, $mid, $this) {
            if(!$id || !$mid){layer.msg("出错了，稍后再来点赞吧.");return false;}
            var option = {
                url: "/index/zan/add",
                dataType: "json",
                type: "post",
                data: {aid:$id,mid:$mid},
                success:function (data) {
                    if(data.code == 0){
                        layer.msg(data.msg,{icon:2});
                        return false;
                    }else if(data.code == 1){
                        if($mid == 30){
                            $this.text('已赞');
                            $this.addClass('layui-btn-danger');
                            var dom = $this.siblings('p').find('.fly-case-nums');
                            var num = parseInt(dom.text());
                            num += 1;
                            dom.text(num)
                            layer.tips(data.msg, $this, {tips:1})
                        }else{
                            layer.tips(data.msg, $this.parent(), {tips:1})
                            $this.toggleClass('active');
                        }
                    }else if(data.code == 2){
                        if($mid == 30){
                            $this.text('赞');
                            $this.removeClass('layui-btn-danger');
                            var dom = $this.siblings('p').find('.fly-case-nums');
                            var num = parseInt(dom.text());
                            if(num > 0){
                                num -= 1;
                            }
                            dom.text(num)
                            layer.tips(data.msg, $this, {tips:1})
                        }else{
                            layer.tips(data.msg, $this.parent(), {tips:1})
                            $this.toggleClass('active');
                        }
                    }else{
                        layer.msg(data.msg,{icon:2});
                        return false;
                    }
                    return false;
                },
                error:function () {
                    layer.msg("服务器发生错误了，请稍后再试！",{icon:5});
                    return false;
                }
            };
            $.ajax(option);
        }
        ,zanAll: function () {
            var that = this;
            $(".zanThis").on("click", function () {
                var $id = $(this).attr("data-id");
                var $mid = $(this).attr("data-mid");
                that.zan($id, $mid, $(this));
            })
        },
        fans: function ($id, $this) {
            if(!$id){layer.msg("出错了，稍后再来关注吧.");return false;}
            var option = {
                url: app.config.baseUrl+"/fans/fans_add.do",
                dataType: "json",
                type: "post",
                data: {userId:$id},
                success:function (data) {
                    if(data.code == 0){
                        layer.msg(data.msg,{icon:2});
                    }else if(data.code == 1){
                        $this.text('取消关注');
                        $this.css("color", '#FFF');
                        layer.tips(data.msg, $this, {tips:1})
                    }else if(data.code == 2){
                        $this.text('关注');
                        $this.css("color", '#FFF');
                        layer.tips(data.msg, $this, {tips:1})
                    }
                    return false;
                },
                error:function () {
                    layer.msg("服务器发生错误了，请稍后再试！",{icon:5});
                    return false;
                }
            };
            $.ajax(option);
        }
        ,fansAll: function () {
            var that = this;
            $(".fansThis").on("click", function () {
                var $id = $(this).attr("data-id");
                that.fans($id, $(this));
            })
        },
        refresh: function () {
            $.pjax.reload('#container', {fragment:'#container', timeout:8000})
        }
        /**
         * F5刷新局部
         * @constructor
         */
        ,F5: function () {
            $('body').keydown(function (e) {
                var ev = window.event || e;
                var code = ev.keyCode || ev.which;
                if(code == 116){
                    if(ev.preventDefault){
                        ev.preventDefault();
                    }else{
                        ev.keyCode = 0;
                        ev.returnValue = false;
                    }
                    active.refresh();
                }
            })
        },
        /**
         * 刷新验证码
         */
        refreshCapt: function () {
            $(".refreshCapt").on("click", function () {
                var time = Date.parse(new Date());
                $(this).find('img').attr('src', '/captcha?id=' + time);
            })
        },

        setUserPhoto: function () {
            if ($('.upload-img')[0]) {
                layui.use('upload', function (upload) {
                    var avatarAdd = $('.avatar-add');
                    upload.render({
                        elem: '.upload-img'
                        , url: app.config.baseUrl+"/admin/admin_uploadFile.do"
                        , size: 6000
                        , before: function () {
                            avatarAdd.find('.loading').show();
                        }
                        , done: function (res) {
                            if (res.code == 0) {
                                  $("#fileFileName").val(res.name);
                                  $("#fileFileNamesrc").attr("src",res.path);
                            } else {
                                layer.msg(res.msg, {icon: 5});
                            }
                            avatarAdd.find('.loading').hide();
                        }
                        , error: function () {
                            avatarAdd.find('.loading').hide();
                        }
                    });
                });
            }
        },
        setUserMp3: function () {
            if ($('.upload-mp3')[0]) {
                layui.use('upload', function (upload) {
                    var avatarAdd = $('.avatar-add');
                    upload.render({
                        elem: '.upload-mp3'
                        , url: app.config.baseUrl+"/admin/admin_uploadFile.do"
                        , size: 10000
                        ,accept: 'audio' //音频
                        , before: function () {
                            avatarAdd.find('.loading').show();
                        }
                        , done: function (res) {
                            if (res.code == 0) {
                                  $("#fileFileName").val(res.name);
                                  $("#fileFileNamesrc").attr("src",res.path);
                            } else {
                                layer.msg(res.msg, {icon: 5});
                            }
                            avatarAdd.find('.loading').hide();
                        }
                        , error: function () {
                            avatarAdd.find('.loading').hide();
                        }
                    });
                });
            }
        },
        sign: function () {
            //签到
            var tplSignin = ['{{# if(d.signed){ }}'
                , '<button class="layui-btn layui-btn-disabled">今日已签到</button>'
                , '<span> 已获得<cite>{{ d.experience }}</cite>积分</span>'
                , '{{# } else { }}'
                , '<button class="layui-btn layui-btn-danger" id="LAY_signin">今日签到</button>'
                , '<span> 可获得<cite>{{ d.experience }}</cite>积分</span>'
                , '{{# } }}'].join('')
                , tplSigninDay = '已连续签到<cite>{{ d.days }}</cite>天'

                , signRender = function (data) {
                laytpl(tplSignin).render(data, function (html) {
                    elemSignMain.html(html);
                });
                laytpl(tplSigninDay).render(data, function (html) {
                    elemSignDays.html(html);
                });
            }

                , elemSignHelp = $('#LAY_signinHelp')
                , elemSignTop = $('#LAY_signinTop')
                , elemSignMain = $('.singIn-main')
                , elemSignDays = $('.fly-signin-days');

            $('body').on('click', '#LAY_signin', function () {
                var othis = $(this);
                if (othis.hasClass(DISABLED)) return;

                fly.json('/index/sign/add', {
                    token: signRender.token || 1
                }, function (res) {
                    signRender(res.data);
                }, {
                    error: function () {
                        othis.removeClass(DISABLED);
                    }
                });

                othis.addClass(DISABLED);
            });

            //签到说明
            elemSignHelp.on('click', function () {
                layer.open({
                    type: 1
                    , title: '签到说明'
                    , area: '300px'
                    , shade: 0.8
                    , shadeClose: true
                    , content: ['<div class="layui-text" style="padding: 20px;">'
                        , '<blockquote class="layui-elem-quote">“签到”可获得积分，规则如下</blockquote>'
                        , '<table class="layui-table">'
                        , '<thead>'
                        , '<tr><th>连续签到天数</th><th>每天可获积分</th></tr>'
                        , '</thead>'
                        , '<tbody>'
                        , '<tr><td>＜5</td><td>3</td></tr>'
                        , '<tr><td>≥10</td><td>6</td></tr>'
                        , '<tr><td>≥20</td><td>12</td></tr>'
                        , '<tr><td>≥30</td><td>24</td></tr>'
                        , '</tbody>'
                        , '</table>'
                        , '<ul>'
                        , '<li>中间若有间隔，则连续天数重新计算</li>'
                        , '<li style="color: #FF5722;">不可利用程序自动签到，否则积分清零</li>'
                        , '</ul>'
                        , '</div>'].join('')
                });
            });

            //签到活跃榜
            var tplSigninTop = ['{{# layui.each(d.data, function(index, item){ }}'
                , '<li>'
                , '<a href="/index/user/index/id/{{item.uid}}.html" target="_blank">'
                , '<img src="{{item.user.avatar}}">'
                , '<cite class="fly-link">{{item.user.username}}</cite>'
                , '</a>'
                , '{{# var date = new Date(item.time); if(d.index < 2){ }}'
                , '<span class="fly-grey">签到于 {{ layui.laytpl.digit(date.getHours()) + ":" + layui.laytpl.digit(date.getMinutes()) + ":" + layui.laytpl.digit(date.getSeconds()) }}</span>'
                , '{{# } else { }}'
                , '<span class="fly-grey">已连续签到 <i>{{ item.days }}</i> 天</span>'
                , '{{# } }}'
                , '</li>'
                , '{{# }); }}'
                , '{{# if(d.data.length === 0) { }}'
                , '{{# if(d.index < 2) { }}'
                , '<li class="fly-none fly-grey">今天还没有人签到</li>'
                , '{{# } else { }}'
                , '<li class="fly-none fly-grey">还没有签到记录</li>'
                , '{{# } }}'
                , '{{# } }}'].join('');

            elemSignTop.on('click', function () {
                var loadIndex = layer.load(1, {shade: 0.8});
                fly.json('/index/sign/index', function (res) { //实际使用，请将 url 改为真实接口
                    var tpl = $(['<div class="layui-tab layui-tab-brief" style="margin: 5px 0 0;">'
                        , '<ul class="layui-tab-title">'
                        , '<li class="layui-this">最新签到</li>'
                        , '<li>今日最快</li>'
                        , '<li>总签到榜</li>'
                        , '</ul>'
                        , '<div class="layui-tab-content fly-signin-list" id="LAY_signin_list">'
                        , '<ul class="layui-tab-item layui-show"></ul>'
                        , '<ul class="layui-tab-item">2</ul>'
                        , '<ul class="layui-tab-item">3</ul>'
                        , '</div>'
                        , '</div>'].join(''))
                        , signinItems = tpl.find('.layui-tab-item');

                    layer.close(loadIndex);

                    layui.each(signinItems, function (index, item) {
                        var html = laytpl(tplSigninTop).render({
                            data: res.data[index]
                            , index: index
                        });
                        $(item).html(html);
                    });

                    layer.open({
                        type: 1
                        , title: '签到活跃榜 - TOP 20'
                        , area: '300px'
                        , shade: 0.8
                        , shadeClose: true
                        , id: 'layer-pop-signintop'
                        , content: tpl.prop('outerHTML')
                    });

                }, {type: 'get'});
            });
        },

        /**
         * 绑定相册点击时间
         */
        photos: function () {
            if ($(window).width() > 750) {
                layer.photos({
                    photos: '.photos'
                    , zIndex: 9999999999
                    , anim: 0
                });
            } else {
                $('body').on('click', '.photos img, .single-content img', function () {
                    window.open(this.src);
                });
            }
        },

        /**
         * 搜索点击
         */
        search: function () {
            $('.fly-search').on('click', function () {
                layer.open({
                    type: 1
                    , title: false
                    , closeBtn: false
                    // ,shade: [0.8, '#fff']
                    , shadeClose: true
                    , maxWidth: 10000
                    , skin: 'fly-layer-search'
                    , content: ['<form action="http://cn.bing.com/search">'
                        , '<input autocomplete="off" placeholder="搜索内容，回车跳转" type="text" name="q">'
                        , '</form>'].join('')
                    , success: function (layero) {
                        var input = layero.find('input');
                        input.focus();

                        layero.find('form').submit(function () {
                            var val = input.val();
                            if (val.replace(/\s/g, '') === '') {
                                return false;
                            }
                            input.val('site:ivusic.com ' + input.val());
                        });
                    }
                })
            });
        },
        sendEmail: function () {
            $('#LAY-activate').on('click', function () {
                var email = $(this).attr('email');
                fly.json('/index/index/activate', {}, function (res) {
                    if (res.code === 0) {
                        layer.alert('已成功将激活链接发送到了您的邮箱，接受可能会稍有延迟，请注意查收。', {
                            icon: 1
                        });
                    };
                });
            });
        },
        login: function () {
            form.on('submit(login-submit)', function(data){
                var option = {
                    url: app.config.baseUrl+"/admin/admin_login2.do",
                    type: "post",
                    dataType: "json",
                    data: data.field,
                    success: function (res) {
                        if(!res.success){
                            layer.msg(res.errMsg, {icon:5,shade: 0.7, time:1500});
                            return false;
                        }
                        layer.msg(res.errMsg, {icon:1,shade: 0.7, time:1500});
                        $.pjax({url: app.config.baseUrl+"/admin/admin_home.do", container: '#container'})
                        return false;
                    }
                }
                $.ajax(option);
            });
        },
        register: function () {
            form.on('submit(register-submit)', function(data){
                var option = {
                    url: app.config.baseUrl+"/admin/admin_add.do",
                    type: "post",
                    dataType: "json",
                    data: data.field,
                    success: function (res) {
                        if(res.code != 200){
                            layer.msg(res.msg, {icon:5,shade: 0.7});
                            return false;
                        }
                        layer.msg(res.msg, {icon:1,shade: 0.7}, function () {
                            $.pjax({url: app.config.baseUrl+"/admin/admin_home.do", container: '#container'})
                        });
                        return false;
                    }
                }
                $.ajax(option);
            });
        },
     /*   getCode: function () {
            $('#getCode').click(function(){
                var btn = $(this);
                var mobile = $("input[name='mobile']").val();
                var reg = /^1[3|4|5|7|8][0-9]{9}$/; //验证规则
                var flag = reg.test(mobile); //true
                if(flag){
                    $.ajax({
                        url:"/index/user/sendCode",type:"post",
                        dataType:"json",
                        data:{mobile:mobile},
                        beforeSend:function () {
                            layer.msg("正在发送，请稍后", {icon:16,time:8000,shade:0.7})
                        },
                        success:function (data) {
                            layer.closeAll();
                            if(data.code == 1){
                                layer.msg(data.msg,{icon:1, shade: 0.7},function () {})
                                var count = 120;
                                var resend = setInterval(function(){
                                    count--;
                                    if (count > 0){
                                        btn.val(count+" 秒");
                                        $.cookie("captcha",count,'s60');
                                    }else {
                                        clearInterval(resend);
                                        $.cookie('captcha', 0);
                                        btn.val("获取验证码").removeClass("layui-btn-disabled").removeAttr('disabled');
                                    }
                                }, 1000);
                                btn.attr('disabled',true).addClass("layui-btn-disabled");
                            }else{
                                layer.tips(data.msg,btn);
                            }
                        },
                        error: function () {
                            layer.tips("服务器出错了，请稍后再试",btn);
                        }
                    })
                }else{
                    layer.tips("手机号格式不正确，请重新填写",btn);
                }
            });
        },*/
        ArticleAdd: function () {
            var layedit = layui.layedit, upload = layui.upload, form = layui.form;
            layedit.set({
                uploadImage: {
                    url: app.config.baseUrl+"/admin/admin_uploadFile.do" //接口url
                    ,type: 'post' //默认post
                }
            });
            var index = layedit.build('edit'); //建立编辑器
            var image = $('input[name="photo"]');

            upload.render({
                elem: '#uploadImage'
                ,url: app.config.baseUrl+"/admin/admin_uploadFile.do"
                ,accept: 'file' //普通文件
                ,exts: 'jpg|png|jpeg' //只允许上传压缩文件
                ,size: 1024 //限制文件大小，单位 KB
                ,done: function(res){
                	var $data = JSON.parse(res);
                    if ($data.code == 0) {
                        image.val($data.data.src);
                    } else {
                        layer.msg($data.msg, {icon: 5});
                    }
                }
            })
            form.on("submit(article)", function (data) {
                var that = this;
                data.field.content = layedit.getContent(index)
                $.post(app.config.baseUrl+"/title/title_add.do", data.field, function (res) {
                	var $data = JSON.parse(res);
                    if($data.code == 200){
                        layer.msg($data.msg, {icon:1, time:2000}, function () {
                            $.pjax({
                                url: app.config.baseUrl+'title/title_bbsList.do',
                                container: '#container'
                            });
                            return false;
                        })
                    }else{
                        layer.tips($data.msg, that, {tips: 1});
                        return false;
                    }
                })
                return false;
            });
            form.on("submit(news)", function (data) {
                var that = this;
                data.field.content = layedit.getContent(index)
                data.field.title=$("#title").val();
                $.post(app.config.baseUrl+"/news/news_add.do", data.field, function (res) {
                    var $data = JSON.parse(res);
                    if($data.code == 200){
                        layer.msg($data.msg, {icon:1, time:2000}, function () {
                            $.pjax({
                                url: app.config.baseUrl+'title/title_bbsList.do',
                                container: '#container'
                            });
                            return false;
                        })
                    }else{
                        layer.tips($data.msg, that, {tips: 1});
                        return false;
                    }
                })
                return false;
            });
            form.on("submit(mytitle)", function (data) {
                var that = this;

                data.field.content = layedit.getContent(index);
                data.field.title=$("#title").val();
                data.field.type=$("#type").val();
                $.post(app.config.baseUrl+"/title/title_add.do", data.field, function (res) {
                    var $data = JSON.parse(res);
                    if($data.code == 200){
                        layer.msg($data.msg, {icon:1, time:2000}, function () {
                            $.pjax({
                                url: app.config.baseUrl+'title/title_bbsList.do',
                                container: '#container'
                            });
                            return false;
                        })
                    }else{
                        layer.tips($data.msg, that, {tips: 1});
                        return false;
                    }
                })
                return false;
            });
            form.on("submit(updatenews)", function (data) {
                var that = this;
                data.field.content = layedit.getContent(index);
                data.field.title=$("#title").val();
                data.field.id=$("#id").val();
                $.post(app.config.baseUrl+"/news/news_update.do", data.field, function (res) {
                    var $data = JSON.parse(res);
                    if($data.code == 200){
                        layer.msg($data.msg, {icon:1, time:2000}, function () {
                            $.pjax({
                                url: app.config.baseUrl+'title/title_bbsList.do',
                                container: '#container'
                            });
                            return false;
                        })
                    }else{
                        layer.tips($data.msg, that, {tips: 1});
                        return false;
                    }
                })
                return false;
            });

        },
        linkAdd: function () {
            var upload = layui.upload, form = layui.form;
            var image = $('input[name="logo"]');
            upload.render({
                elem: '#uploadLink'
                ,url: '/index/link/upload'
                ,accept: 'file' //普通文件
                ,exts: 'jpg|png|jpeg' //只允许上传压缩文件
                ,size: 1024 //限制文件大小，单位 KB
                ,done: function(res){
                    if (res.code == 0) {
                        image.val(res.data.src);
                    } else {
                        layer.msg(res.msg, {icon: 5});
                    }
                }
            })
            form.on("submit(link)", function (data) {
                var that = this;
                $.post("/index/link/save", data.field, function (res) {
                    if(res.code == 1){
                        layer.msg(res.msg, {icon:1, time:2000}, function () {
                            active.refresh();
                            return false;
                        })
                    }else{
                        layer.tips(res.msg, that, {tips: 1});
                        return false;
                    }
                })
                return false;
            })
        },
        setClick: function () {
            $(".setClick tr").hover(function () {
                $(this).find(".changeAfter").show();
                $(this).find(".changeBefore").hide();
            }, function () {
                $(this).find(".changeAfter").hide();
                $(this).find(".changeBefore").show();
            })
        },
        setToolTips: function () {
            //Activate the Bootstrap tooltips
            var tooltip = $('.add-tooltip');
            if (tooltip.length)tooltip.tooltip();
            var popover = $('.add-popover');
            if (popover.length)popover.popover();
            $('#navbar-container .navbar-top-links').on('shown.bs.dropdown', '.dropdown', function () {
                $(this).find('.nano').nanoScroller({preventPageScrolling: true});
            });
            $.niftyNav('bind');
            $.niftyAside('bind');
        },
        linkView: function () {
            $(".linkView").on("click", function () {
                var id = $(this).data('id'), url = $(this).data("url");
                $.get("/index/link/view", {id: id})
            })
        }


        // 初始化绑定事件
        ,init: function () {
            this.bannerAbout();     //关于我们banner
            this.setThisPlay();     //歌曲播放
            this.banner();          //首页banner
            this.collectMusic();    //收藏歌曲
            this.comment();         //留言评论
            this.love();            //喜欢、取消喜欢
            this.zanAll();          //赞、取消赞
            this.fansAll();         //关注、取消关注
            this.refreshCapt();     //验证码刷新
            this.setUserPhoto();    //用户头像更改
            this.setUserMp3();    //用户头像更改
            this.sign();            //签到
            this.photos();          //绑定图片
            this.search();          //绑定搜索
            form.render();
            this.sendEmail();
            this.login();
            this.register();
            this.ArticleAdd();
            this.linkAdd();
            this.setClick();
            this.setToolTips();
            this.linkView();
        }
    }

    $(function(){
        /*仿刷新：检测是否存在cookie*/
        if($.cookie("captcha") != 0){
            var count = $.cookie("captcha");
            var btn = $('#getCode');
            btn.val(count+' 秒').attr('disabled',true).addClass("layui-btn-disabled");
            var resend = setInterval(function(){
                count--;
                if (count > 0){
                    btn.val(count+' 秒').attr('disabled',true).addClass("layui-btn-disabled");
                    $.cookie("captcha", count);
                }else {
                    clearInterval(resend);
                    $.cookie('captcha', 0);
                    btn.val("获取验证码").removeClass('layui-btn-disabled').removeAttr('disabled');
                }
            }, 1000);
        }

    });

    $(document).pjax('[data-pjax] a, a[data-pjax], .pagePjax a', '#container', {fragment:'#container', timeout:8000});

    $(document).on('pjax:send', function() {}); //pjax链接点击后显示加载动画；

    $(document).on('pjax:complete', function() { //pjax链接加载完成后隐藏加载动画；
        active.init();
        //显示当前tab
        if (location.hash) {
            element.tabChange('user', location.hash.replace(/^#/, ''));
        }
    });
    $(document).on('pjax:start', function() { //pjax链接加载完成后隐藏加载动画；
        NProgress.start();
        setTimeout(function () {
            NProgress.done();
        }, 10000)
    });
    $(document).on('pjax:end', function() { //pjax链接加载完成后隐藏加载动画；
        NProgress.done();
    });

    // form提交无刷新
    $(document).on('submit', 'form[data-pjax]', function(event) {
        $.pjax.submit(event, '#container', {fragment:'#container', timeout:8000});
    })
    // 初始化
    active.init();

    form.on("select(province)", function (elem) {
        $.post("/index/user/nextCity", {id: elem.value}, function (data) {
            $("select[name=city]").html(data.data)
            form.render('select');
        })
    })
    form.on("select(city)", function (elem) {
        $.post("/index/user/nextCity", {id: elem.value}, function (data) {
            $("select[name=area]").html(data.data)
            form.render('select');
        })
    })
    

	$('form[name="mainform"] input[name="submitButton"]').click(function(){
		 var layedit = layui.layedit, upload = layui.upload, form = layui.form;
		var hasError = false;
		var hasError1 = false;
		var hasError2 = false;
		var index = layedit.build('edit'); //建立编辑器
		alert(layedit.getContent(index));
		$('form[name="mainform"] input[type="text"]').each(function(){
			var rule = $(this).attr("rule");
			if(checkInputTextHasError(this, rule)){
				hasError = true;
			}
		});
		$('form[name="mainform"] input[type="radio"]').each(function(){
			var rule = $(this).attr("rule");
			if(checkRadioHasError(this, rule)) {
				hasError1 = true;
			}
		});
		$('form[name="mainform"] input[type="checkbox"]').each(function(){
			var rule = $(this).attr("rule");
			if(checkCheckboxHasError(this, rule)) {
				hasError2 = true;
			}
		});
		if(!hasError && !hasError1 && !hasError2) {
			document.mainform.submit();
		}
	});
    /*exports('music', active);*/
});

