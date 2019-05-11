# Getting Started

## Connecting to the Evaluation Virtual Machine

To connect to the SDH Mitchell evaluation servers, you will need an VNC client.

### Windows

Download and install [TightVNC](https://www.tightvnc.com/).

Run TightVNC. Connect to `hostname:n` where `hostname` is the domain name
of the server with which you were provided and
`n` is the machine number that you were
assigned. You should have been provided with a password for the machine.
If you do not have your password, please contact your evaluation administrator.

### Mac

Mac has a built-in VNC client. Open a Finder window or click on your desktop, so
that "Finder" shows in the top-left menu. Then choose in the menu "Go > Connect
to Server". In the window that pops up, put `vnc://hostname:59nn`
where `hostname` is the domain name of the server with which you were provided and
where `nn` is the machine number that you were assigned.
If you have a single-digit machine number, such as `3`, use `03` to replace `nn`.

A login window should pop up asking for your password.
You should have been provided with a password for the machine.
If you do not have your password, please contact your evaluation administrator.

### Linux

On Linux we recommend installing and using the tightvnc package.

```bash
sudo apt-get install tightvnc
vnc hostname:n
```

Replace `hostname` with the domain name of the server with which you were provided and
replace `n` with your machine number.
You should have been provided with a password for the machine.
If you do not have your password, please contact your evaluation administrator.


## Using the Evaluation Virtual Machine

### Editing Mitchell Files

The virtual machine has Visual Studio Code with a plugin for providing syntax
highlighting for the Mitchell language already installed. Open Visual Studio
Code by clicking on the icon in the dock at the bottom of the screen.

In Visual Studio Code, click on the File menu, and choose "New File". Save the
file in the `/work` directory and name it `hello-world.sml`. You may have to
scroll down in the file browser to find the `/work` directory.

Mitchell files use the `.sml` file extension and "Standard ML" Visual Studio
Code editing mode for highlighting. You should see the words "Standard ML" in
the lower right corner of the Visual Studio Code window.

### Saving Your Work

On the virtual machine, save anything that you want to keep in the `/work`
directory, not in your home directory (i.e., not in `~` or `/home/mitchell`). If
we need to update the virtual machine during the evaluation exercise, data
outside of the `/work` directory will not be preserved.

### Locating the Input Data

The input data for the various programs you will be writing is stored in the
`/data` directory. This directory is read-only, so if you need to modify the
data, make a copy in the `/work` directory.

## Creating Your First Mitchell Program

In the `hello-world.sml` file, write

```sml
val _ = print "Hello world!\n";
```

and save the file.

Every statement in a Mitchell program returns a value, however the `print`
function does not return value that you need. If you do not need the value
returned by a statement or expression, you can assign it to `_` (underscore) to
throw it away.

## Running Your First Mitchell Program

Open the terminal by clicking on the icon in the dock. Type

```shell
cd /work
run-mitchell hello-world.sml
```

You should see `Hello world!` printed on the screen.

## Next steps

See the [walkthrough for implementing Graident Boosted Decision Trees in
Mitchell](walkthrough-gbdt.md).
