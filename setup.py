import setuptools

setuptools.setup(
    name="jupyter-airflow-proxy",
    version='0.0.2',
    url="xyurl",
    author="Armadik",
    description="Jupyter extension to proxy Airflow",
    packages=setuptools.find_packages(),
    keywords=['Jupyter'],
    classifiers=['Framework :: Jupyter'],
    install_requires=[
        'jupyter-server-proxy>=3.2.0'
    ],
    entry_points={
        'jupyter_serverproxy_servers': [
            'airflow = jupyter_airflow_proxy:setup_airflow'
        ]
    },
    package_data={
        'jupyter_airflow_proxy': ['icons/airflow-svgrepo-com.svg'],
    },
)
