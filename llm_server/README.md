# LLM Server tips

## To maximise GPU resource, run ubuntu in headless mode

```
sudo systemctl set-default multi-user.target
sudo systemctl stop gdm
sudo reboot
```