component{

	function configure(){
		// Set Full Rewrites
		setFullRewrites( true );

        route( "login" )
            .withHandler( "sessions" )
            .toAction( {
                "GET": "new",
                "POST": "create"
            } );

        post( "logout", "sessions.destroy" );

        route( "/" ).to( "dashboard.index" );

        resources( "users" );
        resources( "organizations" );

        route( "/500" ).toResponse( function( event, rc, prc ) {
            throw( "Boom!  500 error." );
        } );

        route( "/:handler/:action?" ).end();
	}

}
