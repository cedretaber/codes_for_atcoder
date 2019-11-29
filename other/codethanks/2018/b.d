import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xy = readln.split.to!(int[]);
    auto X = xy[0];
    auto Y = xy[1];

    if (Y > X) swap(X, Y);
 
    writeln((X-Y)%2 == 0 && 3*Y-X >= 0 && (3*Y-X)%8 == 0 ? "Yes" : "No");
}

/*

X = 4a + 3b
Y = 4a + b

b = (X - Y)/2

2Y = 8a + X - Y
a = (3Y - X)/8

*/