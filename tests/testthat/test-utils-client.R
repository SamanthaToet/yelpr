test_that("client secret has class `closure`", {
        #expect_type(yelp_key, "closure")
        show_failure(expect_type(yelp_key, "character"))
        expect_error(yelp_key, "Yelp key is invalid")
        expect_is(yelp_key, "yelp_key")
})
