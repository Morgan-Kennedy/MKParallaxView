MKParallaxView
==============

MKParallaxView is an easy to use framework used to create the IOS 7 Parallax Effect (Dynamic Background) on any of your apps! 

Treat it just like a UIImageView and by simply assigning an image to it with 1 line you have the exact same effect for the background of your app.

<code>#import "MKParallaxView.h"</code>

To create the parallax view with a <b>basic</b> background image do the following:

<code>MKParallaxView *basicBackground = [[MKParallaxView alloc] initWithFrame:self.frame];</code>
<code>basicBackground.backgroundImage = [UIImage imageNamed:@"backgroundImage.png"];</code>

To create the parallax view with a <b>repeat</b> background image do the following:

<code>MKParallaxView *repeatBackgound = [[MKParallaxView alloc] initWithFrame:self.frame];</code>
<code>repeatBackgound.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];</code>

I hope you enjoy this framework. Please <b>star</b> it above; and if your iTunes app uses it, please <b>add it to the list</b> on the wiki along with an iTunes link.

Thank you,

Kind Regards

Morgan Kennedy
