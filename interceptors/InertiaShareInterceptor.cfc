component {

    property name="inertia" inject="provider:Inertia@cbInertia";
    property name="auth" inject="provider:AuthenticationService@cbauth";

    function preProcess() {
        inertia.share( "auth", {
            "user": function() {
                return auth.check() ?
                    auth.user().loadRelationship( "account" ).getMemento() :
                    javacast( "null", "" );
            }
        } );
        inertia.share( "flash", { "success": false } );
        inertia.share( "errors", {} );
    }

}
