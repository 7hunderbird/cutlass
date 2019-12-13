start: vbox-start bosh-routes cf-start

stop: vbox-save

down: bosh-delete deep-state

bosh: update deep-state size-superman bosh-create bosh-set-dns bosh-delete-rc bosh-routes

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

deep-state:
	bin/deep-state

size-superman:
	bin/size-superman

size-clark:
	bin/size-clark

update:
	bin/update

vbox-start:
	bin/vbox-start

vbox-save:
	bin/vbox-save