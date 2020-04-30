component secured {

    function index( event, rc, prc ) {
        inertia( "Organizations/Index", {
            "filters": event.getOnly( [ "search", "trashed" ] ),
            "organizations": auth().user().account.organizations()
                .orderBy( "name" )
                .filter( event.getOnly( [ "search", "trashed" ] ) )
                .paginate()
        } );
    }

}
