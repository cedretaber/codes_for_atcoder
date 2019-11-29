import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto S = readln.chomp.to!(char[]);
    foreach (ref c; S) {
        switch (c) {
            case 'O':
            case 'D':
                c = '0';
                break;
            case 'I':
                c = '1';
                break;
            case 'Z':
                c = '2';
                break;
            case 'S':
                c = '5';
                break;
            case 'B':
                c = '8';
                break;
            default:
        }
    }
    writeln(S);
}