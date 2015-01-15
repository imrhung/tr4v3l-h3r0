<!DOCTYPE html>
<html lang='en'>
    <head>
        <meta name="viewport" content='width=device-width, initial-scale=1'>
        <meta charset="utf-8">
        <title>Welcome to Hero for Zero</title>

        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>assets/css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>assets/css/hero.css" media="screen" />
        <link rel="shortcut icon" href="<?php echo base_url(); ?>assets/img/favicon.ico" type="image/x-ico">

        <script type="text/javascript" src="<?php echo base_url(); ?>assets/js/jquery-1.9.1.min.js"></script>

        <script>
            (function (i, s, o, g, r, a, m) {
                i['GoogleAnalyticsObject'] = r;
                i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments)
                }, i[r].l = 1 * new Date();
                a = s.createElement(o),
                        m = s.getElementsByTagName(o)[0];
                a.async = 1;
                a.src = g;
                m.parentNode.insertBefore(a, m)
            })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

            ga('create', 'UA-49504439-1', 'heroforzero.be');
            ga('send', 'pageview');

        </script>

    </head>
    <body>
        <div class="container-fluid">
            <div class="row" id="header-video">
                <video width="100%" height="100%" autoplay loop class="blur border-bottom">
                    <source src="<?php echo base_url(); ?>assets/img/demo/hero-hi.mp4" type="video/mp4">
                    <img src="<?php echo base_url(); ?>assets/img/demo/hfz-poster.png" width="100%" height="100%">
                </video>
            </div>

            <div class="row img-center height-0">
                <div id="phone-container" class="send-to-front">
                    <div id="main_image">
                        <img src="<?php echo base_url(); ?>assets/img/demo/iphone6.png" class="img-responsive img-center" width="300" alt="Hero For Zero">
                    </div>
<!--                    <div id="overlay_image">
                        <img src="<?php //echo base_url(); ?>assets/img/HEROforZERO_640x1136.gif" class="img-responsive img-center" width="250" alt="Hero For Zero">
                    </div>-->
                </div>
            </div>

            <!--Content body-->
            <div class="row">
                <div class=" col-md-10 col-md-offset-1">
                    <div class="row border-bottom add-space-above-sm">
                        <div class="col-sm-4 text-blue text-center">
                            <p>
                                Number of children to save in Vietnam under 5:
                            </p>
                            <p class="text-xxlarge font-varela-round"><b><?php echo $children ?></b></p>
                        </div>
                        <div class="col-sm-4 col-sm-offset-4">
                            <div class="row">
                                <button class="btn btn-hero-blue" href="#">Share</button> 
                                <button class="btn btn-hero-blue" href="#">Donate to an NGO</button>
                            </div>
                            <div class="row">
                                <button class="btn btn-hero-blue " href="#">
                                    <div class="row-fluid btn-appstore">
                                        <div class="col-xs-4">
                                            <span class="fa fa-apple fa-4x"></span>
                                        </div>
                                        <div class="col-xs-8">
                                            <span class="text-medium">Available on the</span>
                                            <br>
                                            <span class="text-large">App Store</span>

                                        </div>
                                    </div>


                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row border-bottom add-space-above-sm">
                        <div class="col-sm-4">
                            <!--Fact-->
                            <table class="table ver-center table-noborder table-condensed">
                                <tr>
                                    <td><img src="<?php echo base_url(); ?>assets/img/demo/vn-flag.png" height="20px"></td>
                                    <td class="text-medium">In Vietnam</td>
                                </tr>
                                <tr>
                                    <td>100</td>
                                    <td>children die everyday of preventable death</td>
                                </tr>
                                <tr>
                                    <td>1</td>
                                    <td>child dies every hour from injury mainly drowning or traffic accidents</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>million children suffer permanent physical and brain damage from malnutrition</td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>million children are deprived of clean water</td>
                                </tr>
                                <tr>
                                    <td>12</td>
                                    <td>million children do not have access to hygienic latrines.</td>
                                </tr>
                            </table>

                        </div>
                        <div class="col-sm-4 col-sm-offset-4">
                            <h4>Top 4: Leaderboard</h4>
                            <!--TODO : Check if empty array first-->
                            <table class="table  ver-center table-noborder table-condensed">
                                <tbody>
                                <?php for ($i=0; $i<count($leader); $i++) :
                                echo "<tr>";
                                    echo "<td>".($i+1) ."</td>";
                                    if ($leader[$i]->avatar == 2){
                                        $image = "boy_hero@2x.png";
                                    } else {
                                        $image = "girl_hero@2x.png";
                                    }
                                    echo "<td><img class='img-circle' src=' ".base_url()."assets/img/player/".$image ."' height='50px'></td>";
                                    echo "<td>".$leader[$i]->name."<br>".$leader[$i]->mark."</td>";
                                echo "</tr>";
                            endfor; ?>
                                </tbody>
                            </table>
                            
                        </div>
                    </div>

                    <!--How it works-->
                    <div class="row  add-space-above-md">
                        <h2 class="text-center">Will you help us save the children?</h2>
                        <h3 class="text-center">Here's how this work:</h3>
                        <!--Three steps-->
                        <div class="col-sm-4">
                            <h3>Step 1: NGOs Know</h3>
                            <p>NGOs who work with and provide for children will create questions, activities and donations for the content of the app</p>
                            <img class="img-responsive" src="<?php echo base_url(); ?>assets/img/demo/admin-website.png" height="750px">
                        </div>
                        <div class="col-sm-4">
                            <h3>Step 2: Educate</h3>
                            <p>You the HERO will educate yourself on how to help and save a child in the virtual world</p>
                            <img class="img-responsive" src="<?php echo base_url(); ?>assets/img/demo/educate.png" height="750px">
                        </div>
                        <div class="col-sm-4">
                            <h3>Step 3: Activate</h3>
                            <p>Participate in NGO's activities, causes, and donations to save children in the real world</p>
                            <img class="img-responsive" src="<?php echo base_url(); ?>assets/img/demo/activate.png" height="750px">
                        </div>
                    </div>

                    <!--Building community-->
                    <div class="row  add-space-above-md add-space-below-sm">
                        <h2 class="text-center">It's more than a game, it's a community of HEROs</h2>
                        <h4 class="text-center add-space-below-sm">Saving children | Building communities</h4>
                        <!--Three groups-->
                        <div class="col-sm-4">
                            <img class="img-responsive" src="<?php echo base_url(); ?>assets/img/demo/partners.png">
                            <p>HEROforZERO is supported by UNICEF Vietnam and having partnered with many great organizations and people who already are saving children's lives in the real world.</p>
                        </div>
                        <div class="col-sm-4">
                            <img class="img-responsive" src="<?php echo base_url(); ?>assets/img/demo/ranking.png">
                            <p>As you progress in your quest to help children you will encounter many rivalries. This will be tracked based on your global point rankings seen in the "Leaderboard" screen.</p>
                        </div>
                        <div class="col-sm-4">
                            <img class="img-responsive" src="<?php echo base_url(); ?>assets/img/demo/together.png">
                            <p>You alone cannot save 7,000,000 children. You must enlist your friends, families, co-workers, and neighbor. With this community we could do our small parts to help save the whole world.</p>
                        </div>
                    </div>

                    <!--Image of characters-->
                    <img class="img-responsive add-space-above-md add-space-below-md" src="<?php echo base_url(); ?>assets/img/demo/all-characters.png">
                    
                    <!--Call for action-->
                    <div class="row  add-space-above-md">
                        <div class="col-sm-8 text-center">
                            <p class="text-medium">Be an agent for change. The only way to save 7,000,000 children is to get a lot of people to save one child at a time. Your 
                                small actions combined makes a big difference. How do you get involved? Play the game and learn through the quizes. Share with your
                                friends or donate to these many great organizations who are the true HEROforZERO.</p>
                        </div>
                        <div class="col-sm-4">
                            <div class="row">
                                <button class="btn btn-hero-blue" href="#">Share</button> 
                                <button class="btn btn-hero-blue" href="#">Donate to an NGO</button>
                            </div>
                            <div class="row">
                                <button class="btn btn-hero-blue " href="#">
                                    <div class="row-fluid btn-appstore">
                                        <div class="col-xs-4">
                                            <span class="fa fa-apple fa-4x"></span>
                                        </div>
                                        <div class="col-xs-8">
                                            <span class="text-medium">Available on the</span>
                                            <br>
                                            <span class="text-large">App Store</span>

                                        </div>
                                    </div>
                                </button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <!--Footer-->
            <div class="row footer-blue text-white add-space-above-md">
                <div class="container">
                <div class="row">
                <!--Message for member-->
                <div class="col-md-7 col-md-offset-1 text-center add-space-above-md">
                    Are you an organization or a person that like helping? You can sign up and help us create content and help to promote your cause and NGO.
                </div>
                <div class="col-md-4 add-space-above-md">
                    <a class="btn btn-hero-blue" href="<?php echo base_url(); ?>login">Login</a>
                    or
                    <a class="btn btn-hero-blue" href="<?php echo base_url(); ?>signup">Sign up</a>
                </div>
                </div>
                <div class="row text-center add-space-above-md add-space-below-sm">
                    <span class="text-xsmall">Copyright HEROforZERO 2015</span>
                </div>
                </div>
            </div>
        </div>
    </body>
</html>