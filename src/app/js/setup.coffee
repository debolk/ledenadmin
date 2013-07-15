( exports ? this ).Bolk = { 
	version: '1.0.0' 
	clientId: 'ledenadmin'
	clientSecret: 'ledenadmin'
}

locache.cachePrefix += '.bolk.'
locache.expirePrefix  += ".bolk."
locache.cleanup()