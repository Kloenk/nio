import XCTest

import SwiftMatrixSDK

@testable import NioKit

class NIORoomTopicEventTests: XCTestCase {
    func testTyped() throws {
        typealias TypedEvent = NIORoomTopicEvent

        let roomId = "!9876543210:example.org"
        let eventId = "$0123456789:example.org"
        let sender = "@example:example.org"
        let topic = "Lorem ipsum"

        let eventOrNil = MXEvent(fromJSON: [
            "room_id": roomId,
            "event_id": eventId,
            "sender": sender,
            "type": "m.room.topic",
            "state_key": "",
            "content": [
                "topic": topic,
            ]
        ])

        let anyTypedEvent = try XCTUnwrap(eventOrNil).typed()
        let typedEvent = try XCTUnwrap(anyTypedEvent as? TypedEvent)

        XCTAssertEqual(typedEvent.roomId, roomId)
        XCTAssertEqual(typedEvent.eventId, eventId)
        XCTAssertEqual(typedEvent.sender, sender)

        XCTAssertEqual(typedEvent.roomTopic, topic)
    }
}
