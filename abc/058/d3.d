import std.stdio, std.algorithm, std.conv, std.array, std.string, std.range;

enum long PRIM = 10^^9+7;

void main()
{
    auto nm = readln.chomp.split(" ").map!(to!long);
    auto n = nm[0];
    auto m = nm[1];

    auto xs = readln.chomp.split(" ").map!(to!long);
    auto ys = readln.chomp.split(" ").map!(to!long);
    
    long xa;
    foreach (x; 0..n)
        xa = (xa + x*xs[x] - (n-x-1)*xs[x])%PRIM;
    
    long ya;
    foreach (y; 0..m)
        ya = (ya + y*ys[y] - (m-y-1)*ys[y])%PRIM;

    writeln((xa*ya)%PRIM);
}