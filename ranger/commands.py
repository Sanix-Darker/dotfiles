from ranger.api.commands import Command


class f(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        try:
            fzf = self.fm.execute_command(
                "fzf --preview='batcat {}' --bind shift-up:preview-page-up,shift-down:preview-page-down",
                universal_newlines=True,
                stdout=subprocess.PIPE
            )
            stdout, stderr = fzf.communicate()
            if fzf.returncode == 0:
                fzf_file = os.path.abspath(stdout.rstrip('\n'))
                if os.path.isdir(fzf_file):
                    self.fm.cd(fzf_file)
                else:
                    self.fm.select_file(fzf_file)
            else:
                if stderr:
                    print(stderr)
        except:
            pass
