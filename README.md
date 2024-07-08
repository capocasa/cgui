cgui
====

A minimal Nim GUI example app that can be cross-compiled to Windows, Mac OS X and Linux, from Linux.

Rapid development for cross-platform GUI apps
---------------------------------------------

The term *rapid development* is a nice one, and it basically means developing software without a lot of screwing around. You are supposed to put your best work into doing stuff that is useful for users rather than little technical challenges that hold you back. You want a very powerful, high-level language, great libraries and highly automated deployment.

*The bad old days*

*Fast development means web apps only*

This used to mean web apps- you take python (or ruby or lisp or whatever) and put it on a server, and the browser is your GUI. It's really fast development because you don't have to worry about a lot of details involving your user's computer.

But sometimes, a GUI app is just a much better fit.

- You might be processing a lot of your user's data
- that data might be too sensitive to give to web site, even if the web site promises 'offline processing'.
- You might want your app to look like a GUI app.
- You might want a lot of control over the user interface, for example making it respond really fast to typing.
- You might want to use your user's computer processing power to keep your infrastructure lean
- You might want to interact with hardware
- You might need real-time processing

You *can* do all of this with web apps, the same way you can pound a nail with a screwdriver.

*An opportunity in the wasteland of trust*

Since fast development also means giving companies access to data, it was a matter of time until companies started abusing this data access, resulting in customer backlash. Adobe requiring legal rights to creative output done with software is the most extreme example so far, but it's only a matter of time until there are more.

As a flip-side, this means a very real opportunity for software emphasizing trust and privacy to disrupt an otherwise unreachable incumbent.

*The bad old days: GUI app development was slow*

It used to be that if you really needed a cross-platform GUI app you were out of luck and had to go back to torturing your soul with C++, which is not rapid, even if you're good at it. Bundling something like python for three systems is just cumbersome.

*With Nim and uing, it's easy*

But with Nim, this is a non-issue. You can develop any kind of app really fast, and it will also run fast, and tiny. The paradigm of fast development vs fast code is over. And with the `uing` nimble package, we have a really easy-to-use cross-platform native widgets.

*With the cgui example project, deployment is easy, like web apps*

With this example project, I wanted to set up cross-compilation for Windows and Mac OS X, so you can write code and then just run a script and immediately have someting users can download and install. You could also put the script into your version control to have it fully automatic, again, like a web app. (Automatic updates would be a possible next step, but it's a two-edged sword and we're not covering it here just yet)

Get started
-----------

Check out the project, and replace all instances of 'cgui' (the example project's name) with `appname`, using whatever you like to use for search-and-replace in a directory tree. Do the same with `Capocasa`, my name, to your name or whatever your brand is.

```
git clone https://github.com/capocasa/cgui
cd cgui
nimgrep -r cgui -! appname .
nimgrep -r Capocasa -! CompanyName .
mv cgui.nim appname.nim
mv cgui.nims appname.nims
```

Install the cross-compilers
---------------------------

You will need to install osxcross, and mingw-w64. Both have docker images if you prefer, personally I like to install them to my arch system.

Build the app
-------------

You can do the build step in nimble tasks. Have a look at the cgui.nims configuration file for details, it's rather straight forward.

```
nimble build --os:linux
nimble build --os:windows
nimble build --os:macosx
```

You will have a appname.exe in the windows directory, appname in macosx, and linux in the root.

Testing your programs
-----

The most convenient way to test things I know is getting virtual machines using the quickemu project.

```
# install quickemu first

# fetch windows
quickget windows 11

# launch windows
quickemu --vm windows-11.conf  # start windows

# fetch mac os x
quickget macosx ventura

quickemu --vm macosx-ventura.conf  # start macosx

```

Then you can mount `smb://10.0.2.4/qemu` in the machines to get access to your ~/Public directory. Put your compiled programs there.

Note that in both cases, license agreements need to be accepted. I am unfamiliar with the legal details, but I assess the practice is at least readily tolerated by both Microsoft and Apple for testing software for their platforms. Whether that's good enough for you is a call you need to make yourself. If you want to be on the safe side, test with Windows and Mac hardware instead, or get an official Microsoft development virtual machine. We will assume your test machines will have access to ~/Public

Packaging
---------

I have also included minimalistic application packages. After compiling, you can build a Windows MSI for distribution, using the `wixl` program.

```
cd windows
mv cgui.wxs appname.wxs
wget https://github.com/neroist/uing/releases/download/0.7.2/libui.dll
wixl -v appname.wxs
cp appname.msi ~/Public
# you can now double click on appname.msi on your windows system to install

cd ..
cd macosx
mv cgui.app appname.app
cp appname appname.app/Contents/MacOS
wget https://github.com/neroist/uing/releases/download/0.7.2/libui.lib
mv libui.lib appname.app/Contents/MacOS/libui.dylib
cp -R appname.app ~/Public

# you can now drag appname.app to your application folder on OSX and run
```

Further development
-------------------

This is intended as a base example. For a real app deployed to real users, I would probably take this exact setup and put it onto a linux server, and run it with a git hook. I would also add the OSX app to a DMG image, and the linux binary to a tarball to have finished app packages as soon as I push my code.

Having a docker image available with all toolchains installed that works out of the box would be really nice, for those who enjoy using docker. That would be especially great for a build server.

Another area that could be looked into is automatic updates, but I do notice that often enough, users don't want automatic updates. And since your code is not exposed to the internet, it might be perfectly workable to let your users update manually.

What is yet unclear is the nuts and bolts of using `libui-ng`, the base of the `uing` package. There are probably various warts that might need to be worked around. But the experience so far has been quite good- libui-ng seems remarkably mature.

What would be really nice would be some way to include native phone widgets, but I am unfamiliar with native phone toolkits for Nim so far. So I will assume phones will be using a different user interface, sharing the non-UI code with computer GUI projects.

Closing remarks
---------------

While this still requires a bit of work to set up the cross compilers, setting up python or something like that on a web server also requires a bit of work.

So we can safely say that developing GUI apps is about in the same ballpark of development speed as developing web apps when you use Nim, if you do a bit of automation.

While might seem a bit counter-intuitive at first glance, using web apps for everything is driven by convenience of development, not convenience of use, so because you have better Economics with Nim, you can afford to go against the trend.


