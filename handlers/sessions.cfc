component {

    property name="inertia" inject="Inertia@cbInertia";
    property name="auth" inject="AuthenticationService@cbauth";

    function new( event, rc, prc ) {
        inertia.render( "Auth/Login" );
    }

    function create( event, rc, prc ) {
        validateOrFail( target = rc, constraints = {
            "email": { "required": "true", "type": "email" },
            "password": { "required": "true" },
            "remember": { "type": "boolean" }
        } );

        try {
            auth.authenticate( rc.email, rc.password );
            relocate( uri = "/" );
        } catch ( InvalidCredentials e ) {
            writeDump( var = e, abort = true );
        }
    }

}
