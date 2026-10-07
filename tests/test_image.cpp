#include "image.hpp"

#include "cassert"
#include "iostream"

int main() {

    Image image = load_image( "assets/image.jpg" );

    assert( image.width() > 0 );
    assert( image.height() > 0 );
    assert( image.data() != nullptr );

    std::cout << "test image: PASS\n";

}