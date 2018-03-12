import os
import sublime

home = os.path.expanduser("~")
nvm_default_file_path = '/%(home)s/.nvm/alias/default' % {'home': home}
window = sublime.active_window()
project_root = os.path.dirname(window.project_file_name())
nvmrc_file_path = os.path.join(project_root, '.nvmrc')

if (os.path.exists(nvmrc_file_path)):
    with open(nvmrc_file_path, 'r') as content_file:
        content = content_file.read()

elif (os.path.exists(nvm_default_file_path)):
    with open(nvm_default_file_path, 'r') as content_file:
        content = content_file.read()

if content:
    version = content.strip()
    print('Version', version)
    path = "%(home)s/.nvm/%(version)s/bin:/%(home)s/.nvm/%(version)s/lib:/%(home)s/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" % {'version':version, 'home':home}
    print('Path', path)
    os.environ["PATH"] = path
