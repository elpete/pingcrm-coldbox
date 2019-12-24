component {

    function up( schema, query ) {
        schema.create( "users", function( table ) {
            table.increments( "id" );
            table.unsignedInteger( "account_id" ).references( "id" ).onTable( "accounts" );
            table.string( "first_name", 25 );
            table.string( "last_name", 25 );
            table.string( "email", 50 ).unique();
            table.string( "password" ).nullable();
            table.boolean( "owner" ).default( 0 );
            table.string( "photo_path", 100 ).nullable();
            table.string( "remember_token", 100 ).nullable();
            table.timestamp( "created_date" );
            table.timestamp( "modified_date" );
            table.timestamp( "deleted_date" ).nullable();
        } );
    }

    function down( schema, query ) {
        schema.drop( "users" );
    }

}
