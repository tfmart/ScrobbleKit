//
//  SBKSearchPeriod.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

/// Represents the time periods available for Last.fm chart and statistic queries.
public enum SBKSearchPeriod: String {
    /// Represents all-time statistics.
    case overall
    
    /// Represents statistics for the last 7 days.
    case sevenDays = "7day"
    
    /// Represents statistics for the last month.
    case oneMonth = "1month"
    
    /// Represents statistics for the last 3 months.
    case threeMonths = "3month"
    
    /// Represents statistics for the last 6 months.
    case sixMonths = "6month"
    
    /// Represents statistics for the last 12 months.
    case twelveMonths = "12month"
}
