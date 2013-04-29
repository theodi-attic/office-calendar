office-calendar
===============

[![Build Status](http://jenkins.theodi.org/job/office-calendar-build-master/badge/icon)](http://jenkins.theodi.org/job/office-calendar-build-master/)
[![Dependency Status](https://gemnasium.com/theodi/office-calendar.png)](https://gemnasium.com/theodi/office-calendar)
[![Code Climate](https://codeclimate.com/github/theodi/office-calendar.png)](https://codeclimate.com/github/theodi/office-calendar)

Shows the availability of pods, desks and meeting rooms for members at the ODI offices

License
-------

This code is open source under the MIT license. See the LICENSE.md file for 
full details.

Setting up the Google Apps API
------------------------------

This is rather a brittle process, and there's a few steps that need to be followed for everything to work. It's documented [here](https://developers.google.com/drive/delegation), but I'll spell it out here too:

* Set up a new project in the [Google API console](https://code.google.com/apis/console), this needs to have access to the Google Calendar API
* Set up a service account, download the private key (and put it in the root of the Rails project), and copy and paste the public key fingerprint into the appropriate place in the `.env` file
* Copy the service account email address, put it in the appropriate place in the `.env` file too, and also put an email address (which will need to be a domain admin) that the service account will act on behalf of in the `GAPPS_USER_EMAIL` entry. You will also need to put their pasword too, but hopefully this step will go away in future
* With the service account email still in your clipboard, add the service account to your team (under 'team' in the API console), and make them an owner.
* Go back to the 'API Access' section, and copy the service account Client ID, now go to your domain admin section (in the format `http://google.com/a/{YOUR DOMAIN}`)
* Go to 'Advanced tools', and choose 'Manage third party OAuth access'
* Paste the Client ID into the box marked 'Client name', and enter `http://www.google.com/calendar/feeds/, https://www.googleapis.com/auth/calendar` (comma seperated, or it won't work!) into the API scopes box. Click 'Authorize'
* Erm
* That's it

Testing
-------

We use [Poltergeist](https://github.com/jonleighton/poltergeist) for some of the testing (because Javascript), so you'll need to make sure phantom.js is installed on your machine. You can do this as follows:

### Mac ###

* *Homebrew*: `brew install phantomjs`
* *MacPorts*: `sudo port install phantomjs`
* *Manual install*: [Download this](http://code.google.com/p/phantomjs/downloads/detail?name=phantomjs-1.8.1-macosx.zip&can=2&q=)

### Linux ###

* Download the [32
bit](http://code.google.com/p/phantomjs/downloads/detail?name=phantomjs-1.8.1-linux-i686.tar.bz2&can=2&q=)
or [64
bit](http://code.google.com/p/phantomjs/downloads/detail?name=phantomjs-1.8.1-linux-x86_64.tar.bz2&can=2&q=)
binary.
* Extract the tarball and copy `bin/phantomjs` into your `PATH`

### Manual compilation ###

Do this as a last resort if the binaries don't work for you. It will
take quite a long time as it has to build WebKit.

* Download [the source tarball](http://code.google.com/p/phantomjs/downloads/detail?name=phantomjs-1.8.1-source.zip&can=2&q=)
* Extract and cd in
* `./build.sh`

(See also the [PhantomJS building
guide](http://phantomjs.org/build.html).) 