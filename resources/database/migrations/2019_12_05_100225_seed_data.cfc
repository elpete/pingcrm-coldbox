component {

    function up( schema, query ) {
        var accountId = query.newQuery().table( "accounts" ).insert( {
            "name" = "Acme Corporation"
        } ).result.generatedKey;

        systemOutput( accountId );

        query.newQuery().table( "users" ).insert( {
            "account_id": accountId,
            "first_name": "John",
            "last_name": "Doe",
            "email": "johndoe@example.com",
            "password": "$2a$12$1VHpVoEg525gaEhhMjWrMuCJS3hZ2VPhL6roHhWv8uN/8IgfaYQBq",
            "remember_token": "ashn4wior1",
            "owner": 1
        } );
    }

    function down( schema, query ) {

    }

}
