import getpass
import os
import shutil


def get_airflow_executable(prog):
    # Find prog in known locations
    other_paths = [
        os.path.join('/usr/bin/', prog),
        os.path.join('/opt/conda/bin/', prog),
    ]
    if shutil.which(prog):
        return prog

    for op in other_paths:
        if os.path.exists(op):
            return op

    raise FileNotFoundError(f'Could not find {prog} in PATH')


def get_icon_path():
    return os.path.join(
        os.path.dirname(os.path.abspath(__file__)), 'icons', 'airflow-svgrepo-com.svg'
    )


def setup_airflow():
    def _get_env(port):
        return dict(USER=getpass.getuser(),
                    AIRFLOW__WEBSERVER__ENABLE_PROXY_FIX=str('True'),
                    )

    def _get_cmd(port):
        cmd = [
            get_airflow_executable('supervisord'),
            '-c',
            '/etc/supervisord.conf',
        ]

        return cmd

    server_process = {
        'command': _get_cmd,
        'environment': _get_env,
        'timeout': 120,
        'port': 8080,
        'launcher_entry': {
            'title': 'Airflow',
            'icon_path': get_icon_path()
        }
    }
    return server_process
