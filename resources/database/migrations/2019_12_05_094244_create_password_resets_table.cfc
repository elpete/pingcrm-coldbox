component {

    function up( schema, query ) {
        schema.create( "password_resets", function( table ) {
            table.string( "email" ).references( "email" ).onTable( "users" );
            table.string( "token" );
            table.timestamp( "created_date" ).nullable();
            table.primaryKey( [ "email", "token" ] );
        } );
    }

    function down( schema, query ) {
        schema.drop( "password_resets" );
    }

}
