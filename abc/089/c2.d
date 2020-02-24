import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long m, a, r, c, h;
    foreach (_; 0..N) {
        switch (readln[0]) {
            case 'M': ++m; break;
            case 'A': ++a; break;
            case 'R': ++r; break;
            case 'C': ++c; break;
            case 'H': ++h; break;
            default:
        }
    }
    writeln(
        m*a*r + m*a*c + m*a*h + m*r*c + m*r*h + m*c*h +
        a*r*c + a*r*h + a*c*h +
        r*c*h
    );
}