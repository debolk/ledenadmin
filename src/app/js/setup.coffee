( exports ? this ).Bolk = { 
	version: '1.0.0' 
	clientId: 'ledenadmin-dev'
	clientSecret: 'ledenadmin-dev'
	baseUrl: 'https://ledenadmin-dev.i.bolkhuis.nl/'
}

locache.cachePrefix += '.bolk.'
locache.expirePrefix  += ".bolk."
locache.cleanup()
