# jupyter_airflow_proxy for jupyterhub

jupyter_airflow_proxy provides Jupyter server and notebook extensions to proxy Airflow.

![img.png](img.png)

## Setting build

Requirements:
Build

```bash
python3 setup.py sdist bdist_wheel
```
output: 
```
dist\jupyter_airflow_proxy-0.0.1-py3-none-any.whl
```

### Install jupyter_airflow_proxy

Install the library via `pip`:
```
pip install jupyter_airflow_proxy-0.0.1-py3-none-any.whl

```
### Create user

```bash
airflow users create \
      --username Admin \
      --firstname FIRST_NAME \
      --lastname LAST_NAME \
      --role Admin \
      --email admin@example.org
```

## License

MIT © Richard McRichface