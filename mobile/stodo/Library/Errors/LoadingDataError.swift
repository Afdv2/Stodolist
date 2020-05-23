import Foundation

enum LoadingDataError: Error {
    case emptyData
    case decode(_ message: String)
    case loading(_ message: String)
}

extension LoadingDataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyData:
            return NSLocalizedString("Данных нет", comment: "")
        case .decode:
            return NSLocalizedString("Ошибка обработки данных", comment: "")
        case .loading:
            return NSLocalizedString("Ошибка подключения. Попробуйте повторить позднее", comment: "")
        }
    }
}
