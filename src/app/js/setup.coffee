( exports ? this ).Bolk = { 
	version: '1.0.0' 
	clientId: 'testclient'
	clientSecret: 'verysecret'
}

locache.cachePrefix += '.bolk.'
locache.expirePrefix  += ".bolk."
locache.cleanup()