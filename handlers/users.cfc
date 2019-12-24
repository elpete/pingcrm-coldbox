component secured {

    property name="inertia" inject="Inertia@cbInertia";

    function index( event, rc, prc ) {
        inertia.render( "Users/Index", {
            "filters": event.getOnly( [ "search", "role", "trashed" ] ),
            "users": auth().user().getAccount().users()
                .orderByName()
                .filter( event.getOnly( [ "search", "role", "trashed" ] ) )
                .get()
                .map( function( user ) {
                    return {
                        "id" = user.getId(),
                        "name" = user.getName(),
                        "email" = user.getEmail(),
                        "owner" = user.getOwner(),
                        "photo" = user.getPhotoPath(),
                        "deleted_at" = user.getDeletedDate(),
                    }
                } )
        } );
    }

    function new( event, rc, prc ) {
        inertia.render( "Users/Create" );
    }

    function create( event, rc, prc ) {
        var data = validateOrFail( target = rc, constraints = {
            "first_name": { "required": true, "size": "1..50" },
            "last_name": { "required": true, "size": "1..50" },
            "email": { "required": true, "size": "1..50", "type": "email" }, // add unique rule
            "password": { "required": false },
            "owner": { "required": true, "type": "boolean" }
        } );

        auth().user().getAccount().users().create( {
            "first_name" = data.first_name,
            "last_name" = data.last_name,
            "email" = data.email,
            "password" = event.getValue( "password", "" ),
            "owner" = data.owner
            // add photo
        } );

        relocate( "users" );
    }

    function edit( event, rc, prc ) {
        var user = auth().user().getAccount().users().findOrFail( rc.id );
        inertia.render( "Users/Edit", {
            "user": {
                "id": user.getId(),
                "first_name": user.getFirstName(),
                "last_name": user.getLastName(),
                "email": user.getEmail(),
                "owner": user.getOwner(),
                "photo": user.getPhotoPath(),
                "deleted_at": user.getDeletedDate()
            }
        } );
    }

    function update( event, rc, prc ) {
        var user = auth().user().getAccount().users().findOrFail( rc.id );
        var data = validateOrFail( target = rc, constraints = {
            "first_name": { "required": true, "size": "1..50" },
            "last_name": { "required": true, "size": "1..50" },
            "email": { "required": true, "size": "1..50", "type": "email" }, // add unique rule
            "password": { "required": false },
            "owner": { "required": true, "type": "boolean" }
        } );

        user.update( event.getOnly( [ "first_name", "last_name", "email", "owner" ] ) );

        if ( event.valueExists( "password" ) ) {
            user.update( { "password": rc.password } );
        }

        relocate( event = "users.#rc.id#.edit", statusCode = 303 );
    }

    function delete( event, rc, prc ) {
        auth().user().getAccount().users().findOrFail( rc.id ).delete();

        relocate( event = "users", statusCode = 303 );
    }

}
