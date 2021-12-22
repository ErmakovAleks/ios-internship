import Foundation

extension NSLocking {
    func `do`<Result>( _ action: () -> Result) -> Result {
        self.lock()
        defer { self.unlock() }
        
        return action()
    }
}
