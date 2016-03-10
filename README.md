# pwdtasks

pwdtask is a PowerShell module that automatically loads and unloads "tasks"
based on your current working directory.

## Installation

1. Install via the [PowerShell Gallery](https://www.powershellgallery.com/packages/pwdtasks): `Install-Module pwdtasks`

2. Import the module your `$profile`: `Import-Module pwdtasks`

3. In your project's root directory, create a `.powershell/tasks.psm1` module
and put all of your helper functions, *tasks*, in there.

4. Now whenever your `$pwd` is inside that project's directory, `pwdtasks` will
automatically `Import-Module .powershell/tasks.psm1`. When you leave your
project directory then `tasks.psm1` will be unloaded. Magic!

## Examples

Look at the `sample` directory in this repository. 

## License

**The MIT License (MIT)**  
Copyright (c) 2016 Joshua Poehls

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associateddocumentation files (the "Software"), to deal in the
Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.