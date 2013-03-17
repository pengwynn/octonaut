# Octonaut

A little CLI sugar for the GitHub API.

### Why not `hub`?

[hub][] is great, you should use it. But hub focuses mostly on smoothing the
git workflow for GitHub and most commands are in the context of a GitHub
repository.

Octonaut is more general purpose CLI for the GitHub API.

### Installation

Install via Rubygems:

```
gem install octonaut
```

### Example usage

View a user's profile:

```
$ octonaut whois cloudhead
       ID 40774
   JOINED 2008-12-16T15:09:49Z
    LOGIN cloudhead
     NAME Alexis Sellier
  COMPANY SoundCloud, Ltd.
 LOCATION Berlin
FOLLOWERS 2347
FOLLOWING 48
 HIREABLE true
      URL http://twitter.com/cloudhead
```

Browse a user on github.com in your default browser:

```
$ octonaut browse cloudhead
```

List followers:
```
$ octonaut followers pengwynn
krisbulman
camdub
cglee
nextmat
zachinglis
seaofclouds
njonsson
davidnorth
polomasta
webiest
mchelen
brogers
marclove
adamstac
marshall
asenchi
piyush
rmetzler
nileshtrivedi
sferik
jimmybaker
jnunemaker
peterberkenbosch
leah
jakestutzman
nkabbara
etagwerker
vagostino
johan--
bry4n
...
```

Follow a user:
```
$ octonaut follow linus
Followed linus.
```

Unfollow a user:
```
$ octonaut unfollow pengwynn
Unfollowed pengwynn.
```

## Copyright

Copyright (c) 2013 Wynn Netherland. See [LICENSE][] for details.

[hub]: https://github.com/defunkt/hub
[LICENSE]: https://github.com/pengwynn/octonaut/blob/master/LICENSE.md
