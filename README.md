# Octonaut

A little CLI sugar for the GitHub API, built with [gli][] and [Octokit][].

**Still early. Rapidly evolving.** Why not [help out][contributing]?

### Why not `hub`?

[hub][] is great, you should use it. But hub focuses mostly on smoothing the
git workflow for GitHub and most commands are in the context of a GitHub
repository.

Octonaut is more general purpose CLI for the GitHub API. Oh and [plugins][].

### Installation

Install via Rubygems:

```
gem install octonaut
```

### Example usage
```
$ octonaut

NAME
    octonaut - Octokit-powered CLI for GitHub

SYNOPSIS
    octonaut [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    --help                         - Show this message
    -n, --[no-]netrc               - Use .netrc file for authentication
    -p, --password=arg             - GitHub password (default: ********)
    -t, --oauth_token, --token=arg - GitHub API token (default: ********)
    -u, --login=arg                - GitHub login (default: none)

COMMANDS
    browse           - Browse resource on github.com
    follow           - Follow a user
    followers        - View followers for a user
    following        - View who a user is following
    follows          - Check to see if a user follows another
    help             - Shows a list of commands or help for one command
    hit_me           -
    me               - View your profile
    repo, repository -
    star             -
    starred          -
    unfollow         - Unfollow a user
    unstar           -
    user, whois      - View profile for a user
```

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

## Extend with plugins

Octonaut makes it simple to extend the CLI with new commands just by adding
some Ruby files to `~/.octonaut/plugins`:

```
$ cat ~/.octonaut/plugins/test.rb
module Octonaut

  desc 'An plugin method'
  arg_name 'text'
  command :say do |c|
    c.action do |global,options,args|
      puts @client.say args.shift
    end
  end
end

$ octonaut say "hello from plugins"

           MMM.           .MMM
           MMMMMMMMMMMMMMMMMMM
           MMMMMMMMMMMMMMMMMMM      ____________________
          MMMMMMMMMMMMMMMMMMMMM    |                    |
         MMMMMMMMMMMMMMMMMMMMMMM   | hello from plugins |
        MMMMMMMMMMMMMMMMMMMMMMMM   |_   ________________|
        MMMM::- -:::::::- -::MMMM    |/
         MM~:~   ~:::::~   ~:~MM
    .. MMMMM::. .:::+:::. .::MMMMM ..
          .MM::::: ._. :::::MM.
             MMMM;:::::;MMMM
      -MM        MMMMMMM
      ^  M+     MMMMMMMMM
          MMMMMMM MM MM MM
               MM MM MM MM
               MM MM MM MM
            .~~MM~MM~MM~MM~~.
         ~~~~MM:~MM~~~MM~:MM~~~~
        ~~~~~~==~==~~~==~==~~~~~~
         ~~~~~~==~==~==~==~~~~~~
             :~==~==~==~==~~
```

## Inspiration

Octonaut is inspired by [`t`, the awesome Twitter CLI][t] from [Erik Michaels-Ober][sferik].

## Copyright

Copyright (c) 2013 Wynn Netherland. See [LICENSE][] for details.

[hub]: https://github.com/defunkt/hub
[gli]: https://github.com/davetron5000/gli
[octokit]: https://github.com/pengwynn/octokit
[plugins]: #extend-with-plugins
[contributing]: https://github.com/pengwynn/octonaut/blob/master/CONTRIBUTING.md
[t]: https://github.com/sferik/t
[sferik]: https://github.com/sferik
[LICENSE]: https://github.com/pengwynn/octonaut/blob/master/LICENSE.md
