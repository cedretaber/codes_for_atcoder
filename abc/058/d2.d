import std.stdio, std.algorithm, std.conv, std.array, std.string, std.range;

long PRIM = 1000000007;

void main()
{

    auto nm = readln.chomp.split(" ").map!(to!long);
    auto n = nm[0];
    auto m = nm[1];

    auto xs = readln.chomp.split(" ").map!(to!long);
    auto ys = readln.chomp.split(" ").map!(to!long);
    
    long area;
    foreach (x; 0..n-1)
        foreach (y; 0..m-1)
           area += ( ((xs[x+1] - xs[x])*(ys[y+1] - ys[y]))%PRIM *
            (((x+1)*(y+1))%PRIM * ((n-x-1)*(m-y-1))%PRIM)%PRIM)%PRIM;

    writeln(area%PRIM);
}