//
//  PersistancePart.swift
//  SimpleWeather
//
//  Created by Alexander on 21.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity

class PersistanceDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(DatabaseManager.init)
        container.register(CurrentUserSession.init)
            .injection(\.databaseManager)
    }
}
