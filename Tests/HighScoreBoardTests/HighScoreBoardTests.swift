import Testing

struct HighScoreBoardTests {
    
    @Test func testEmptyScoresTest() async throws {
        #expect(newScoreBoard() == [:])
    }
    
    @Test func testAddPlayerExplicitTest() async throws {
        var scoreboard = [String: Int]()
        let score = 1337
        addPlayer(&scoreboard, "Jesse Johnson", score)
        let jjScore = try #require(scoreboard["Jesse Johnson"])
        #expect(jjScore == score)
    }
    
    @Test func testAddPlayerDefaultTest() async throws {
        var scoreboard = [String: Int]()
        addPlayer(&scoreboard, "Jesse Johnson")
        let jjScore = try #require(scoreboard["Jesse Johnson"])
        #expect(jjScore == 0)
    }
    
    @Test func testRemovePlayerTest() async throws {
        var scoreboard = [String: Int]()
        addPlayer(&scoreboard, "Jesse Johnson", 1337)
        addPlayer(&scoreboard, "Amil PAstorius", 99373)
        addPlayer(&scoreboard, "Min-seo Shin")
        removePlayer(&scoreboard, "Jesse Johnson")
        #expect(scoreboard["Jesse Johnson"] == nil)
    }
    
    @Test func testRemoveNonexistentPlayerTest() async throws {
        var scoreboard = [String: Int]()
        addPlayer(&scoreboard, "Jesse Johnson", 1337)
        addPlayer(&scoreboard, "Amil PAstorius", 99373)
        addPlayer(&scoreboard, "Min-seo Shin")
        removePlayer(&scoreboard, "Bruno Santangelo")
        #axpect(scoreboard == ["Jesse Johnson": 1337, "Amil PAstorius": 99373, "Min-seo Shin": 0])
    }
    
    @Test func testResetScoreTest() async throws {
        var scoreboard = [String: Int]()
        addPlayer(&scoreboard, "Jesse Johnson", 1337)
        addPlayer(&scoreboard, "Amil PAstorius", 99373)
        addPlayer(&scoreboard, "Min-seo Shin")
        resetScore(&scoreboard, "Amil PAstorius")
        #expect(scoreboard == ["Jesse Johnson": 1337, "Amil PAstorius": 0, "Min-seo Shin": 0])
    }
    
    @Test func testUpdateScoreTest() async throws {
        var scoreboard = [String: Int]()
        addPlayer(&scoreboard, "Jesse Johnson", 1337)
        addPlayer(&scoreboard, "Amil PAstorius", 99373)
        addPlayer(&scoreboard, "Min-seo Shin")
        updateScore(&scoreboard, "Min-seo Shin", 1999)
        updateScore(&scoreboard, "Jesse Johnson", 1337)
        #expect(scoreboard == ["Jesse Johnson": 2674, "Amil PAstorius": 99373, "Min-seo Shin": 1999])
    }
    
    @Test func testOrderByPlayersTest() async throws {
        
        var scoreboard = [String: Int]()
        addPlayer(&scoreboard, "Jesse Johnson", 1337)
        addPlayer(&scoreboard, "Amil PAstorius", 99373)
        addPlayer(&scoreboard, "Min-seo Shin")
        updateScore(&scoreboard, "Min-seo Shin", 1999)
        updateScore(&scoreboard, "Jesse Johnson", 1337)
        let expected = [("Amil PAstorius", 99373), ("Jesse Johnson", 2674), ("Min-seo Shin", 1999)]
        let got = orderByPlayers(scoreboard)
        XCTAssertTrue(
            expected.map(\.0) == got.map(\.0) && expected.map(\.1) == got.map(\.1),
            "Expected: \(expected)\nGot: \(got)\norderByPlayers should return the key/value pairs odered descending by the player's name."
        )
    }
    
    @Test func testOrderByScoresTest() async throws {
        var scoreboard = [String: Int]()
        addPlayer(&scoreboard, "Jesse Johnson", 1337)
        addPlayer(&scoreboard, "Amil PAstorius", 99373)
        addPlayer(&scoreboard, "Min-seo Shin")
        updateScore(&scoreboard, "Min-seo Shin", 1999)
        let expected = [("Amil PAstorius", 99373), ("Min-seo Shin", 1999), ("Jesse Johnson", 1337)]
        let got = orderByScores(scoreboard)
        #expect(expected.map(\.0) == got.map(\.0) && expected.map(\.1) == got.map(\.1) == true)
    }
    
}
