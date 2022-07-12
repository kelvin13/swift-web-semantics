import SHA2 

infix operator =~= :ComparisonPrecedence

extension Resource 
{
    @available(*, deprecated, renamed: "Tag")
    public 
    typealias Version = Tag 
    
    @available(*, deprecated, message: "Tag is now SHA256 from the SHA2 module.")
    public 
    typealias Tag = SHA256
}

extension SHA256 
{
    @inlinable public
    var etag:String 
    {
        "\"\(self.description)\""
    }
    @inlinable public 
    init?<ETag>(etag:ETag) where ETag:StringProtocol
    {
        guard case ("\""?, "\""?) = (etag.first, etag.last)
        else 
        {
            return nil 
        }
        self.init(parsing: etag.dropFirst().dropLast().utf8)
    }
}
extension Optional where Wrapped == SHA256
{
    @inlinable public static 
    func =~= (lhs:Self, rhs:Self) -> Bool 
    {
        switch (lhs, rhs)
        {
        case (let lhs?, let rhs?):  return lhs == rhs 
        default:                    return false 
        }
    }
}
