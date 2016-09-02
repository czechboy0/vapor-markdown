import Leaf
import vapor_markdown

public final class Markdown: Tag {
    
    public enum Error: Swift.Error {
        case expectedVariable(Argument?)
    }
    
    public let name = "markdown"
    public let renderer: MarkdownRenderer
    
    public init(renderer: MarkdownRenderer) {
        self.renderer = renderer
    }
    
    public func run(
        stem: Stem,
        context: Context,
        tagTemplate: TagTemplate,
        arguments: [Argument]) throws -> Node? {
        
        guard case .variable(let path)? = arguments.first else {
            throw Error.expectedVariable(arguments.first)
        }
        let filePath = path.path.joined(separator: ".")
        
        let view = try renderer.make(filePath)
        let viewString = view.data.string
        return .string(viewString)
    }
    
    public func shouldRender(
        stem: Stem,
        context: Context,
        tagTemplate: TagTemplate,
        arguments: [Argument],
        value: Node?) -> Bool {
        return true
    }
}
