# webshot based on openSuse:42.1
-
[![](https://images.microbadger.com/badges/image/webdeskltd/lantern.svg)](https://microbadger.com/images/webdeskltd/lantern "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/webdeskltd/lantern.svg)](https://microbadger.com/images/webdeskltd/lantern "Get your own version badge on microbadger.com")

Run it:

	`docker run --rm \
		--name=webshot \
		dckr-webshot \
		--window-size=1024/800 \
		--shot-offset=0/0/0/0 \
		--custom-header="User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1" \
		--http-error \
		--timeout=15000 \
		--shot-callback \
		"http://address.to/your/site" \
		> out.png`

or

	`docker run dckr-webshot`

for more help
