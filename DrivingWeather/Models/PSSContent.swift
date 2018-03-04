import Foundation

class PSSContent: Codable {
    private var _summaryLine1: ContentObject?
    private var _summaryLine2: ContentObject?
    private var _pssGraphData: [PSSGraphData]?
    
    lazy var pssDataPointDescriptions: [String] = {
        
        var pointDescriptions : [String] = []
        
        if _pssGraphData != nil {
            for index in 0..._pssGraphData![0].points!.count - 1 {
                let currentPointDescription = _pssGraphData![0].points![index].text![0]
                pointDescriptions.append(currentPointDescription)
            }
        }
        return pointDescriptions
    }()
    
    lazy var summaryLine1: String?  = {
        return (_summaryLine1 == nil) ? nil : _summaryLine1!.text![0]
    }()
    
    lazy var summaryLine2: String? = {
        return (_summaryLine2 == nil) ? nil : _summaryLine2!.text![0]
    }()
    
    ///Returns the expected time as a string for the index of pss data
    ///ie: '10:00AM: Light Intensity' should return '10:00AM'
    func getButtonLabelForIndex(_ index : Int) -> String? {
        
        if (index >= pssDataPointDescriptions.count) {
            assertionFailure("Attempted to get the button label for index [\(index)] when there were only [\(pssDataPointDescriptions.count)] pss data points.")
        }
        
        let str = pssDataPointDescriptions[index]
        let prefixLength = str.range(of: ":", options: .backwards)?.lowerBound
        
        return String(str.prefix(upTo: prefixLength!))
    }
    
}

extension PSSContent {
    enum CodingKeys: String, CodingKey {
        case _summaryLine1 = "SummaryLine1"
        case _summaryLine2 = "SummaryLine2"
        case _pssGraphData = "Data"
    }
}
