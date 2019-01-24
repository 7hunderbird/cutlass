bosh: bosh-update deep-state bosh-create

bosh-create:
		bin/bosh-create

bosh-update:
		bin/bosh-update

bosh-delete:
		bin/bosh-delete

deep-state:
		bin/deep-state

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

cf: bosh-set-dns cf-update cf-set-cc cf-upload-stemcell cf-create cf-start

cf-create:
		bin/cf-create

cf-update:
		bin/cf-update

cf-delete:
		bin/cf-delete

cf-set-cc:
		bin/cf-set-cc

cf-upload-stemcell:
		bin/cf-upload-stemcell

cf-start:
		bin/cf-start

vbox-start:
		bin/vbox-start