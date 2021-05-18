import React from "react";
import {FacebookIcon, FacebookShareButton,TwitterShareButton, TwitterIcon} from "react-share";

export default function Share() {
    return (
     <div>  
        <div>
            <FacebookShareButton 
            quote={"123456"}
            hashtag="#Assignment 1"
            url="wwww.github.com"
            >
                <FacebookIcon logoFillColor="white" round={true}></FacebookIcon>
            </FacebookShareButton>
        </div>
        <div>
            <TwitterShareButton url="www.github.com"
            title="123456">
                <TwitterIcon logoFillColor="white" round={true}></TwitterIcon>
            </TwitterShareButton>
        </div>
     </div> 
    )
}
