# Open Web UI

* Installation

```
    pip install open-webui
```

* Serve

```
    open-webui serve
```

* Docker

```
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

[More instructions including Docker](https://github.com/open-webui/open-webui)