start: vbox-start bosh-routes cf-start

stop: vbox-save

down: bosh-delete deep-state

bosh: update deep-state bosh-hulk bosh-create bosh-set-dns bosh-delete-rc bosh-routes

cf: cf-set-cc cf-upload-stemcell cf-create cf-start

up: bosh cf

bosh-create:
	bin/bosh-create

bosh-delete:
	bin/bosh-delete

bosh-delete-rc:
	bin/bosh-delete-rc

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
