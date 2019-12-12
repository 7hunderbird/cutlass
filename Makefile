start: vbox-start bosh-routes cf-start

stop: vbox-save

off: bosh-delete deep-state

bosh: update deep-state bosh-create bosh-set-dns bosh-delete-runtime-config

cf: cf-set-cc cf-upload-stemcell cf-create cf-start

bosh-create:
		bin/bosh-create

bosh-delete:
		bin/bosh-delete

bosh-delete-runtime-config:
		bin/bosh-delete-runtime-config

bosh-set-dns:
		bin/bosh-set-dns

bosh-hulk:
		bin/bosh-hulk

bosh-banner:
		bin/bosh-banner

bosh-routes:
		bin/bosh-routes

jumpbox:
		bin/bosh-jumpbox

cf-create:
		bin/cf-create

cf-delete:
		bin/cf-delete

cf-set-cc:
		bin/cf-set-cc

cf-upload-stemcell:
		bin/cf-upload-stemcell

cf-start:
		bin/cf-start

update:
		bin/update

vbox-start:
		bin/vbox-start

vbox-save:
		bin/vbox-save

deep-state:
		bin/deep-state
