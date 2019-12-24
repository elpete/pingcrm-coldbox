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
        route( "/users/:user/restore" ).to( "users.restore" );

        route( "/:handler/:action?" ).end();
	}

}
