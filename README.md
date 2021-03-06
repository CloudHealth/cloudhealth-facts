## Puppet CloudHealth Tech Facts Module

This module installs custom facts needed by the Aggregator.

Installation
----

* Run `puppet module install cloudhealth/facts` on the master.
* Enable pluginsync on the master and client nodes

```
[main]
pluginsync = true
```

* After a run, you should see the custom facts in `/var/opt/lib/pe-puppet/lib/facter` on the clients
* Browse to a node in the PE web console and you should see puppetenvironment, mounts, and vmalloc facts

Facts
----

* Puppet Environment
* VMAlloc* (from /proc/meminfo)
* Mounts _(what "filesystems" should have been)_

### MIT License

Copyright (C) 2013 by CloudHealth Tech

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
