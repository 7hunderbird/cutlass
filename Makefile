bosh:
		update-bosh create-bosh

create-bosh:
		bin/create-bosh

delete-bosh:
		bin/delete-bosh

jumpbox:
		bin/jumpbox

update-bosh:
		bin/update-bosh

source:
		@. state/.envrc

set-dns:
		bin/set-dns

update-cf:
		bin/update-cf

set-cc:
		bin/set-cc

upload-stemcell:
		bin/upload-stemcell

deploy-cf:
		bin/deploy-cf

start-cf:
		bin/start-cf

cf:
		bosh set-dns update-cf set-cc upload-stemcell deploy-cf start-cf