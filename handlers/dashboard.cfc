component secured {

    property name="inertia" inject="Inertia@cbInertia";

    function index( event, rc, prc ) {
        inertia.render( "Dashboard/Index" );
    }

}
