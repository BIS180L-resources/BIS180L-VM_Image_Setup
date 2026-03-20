Updating image for 2026

This year I am starting from 2024's image and upgrading, rather than starting fresh.

There was one third party repo with a certificate problam and that needed to be removed before upgrading.  This was for github desktop

```
cd /etc/apt/sources.list.d/
rm shiftkey-packages.list
```

Then upgrade
```
sudo apt update
sudo apt upgrade
```

Restart the instance (just in case)

I AM HERE

Reinstall Github Desktop

Update Rstudio

Update R

Update R packages

