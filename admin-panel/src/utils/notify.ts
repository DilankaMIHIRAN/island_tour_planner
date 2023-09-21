import { notification } from "antd";


export const notify = (
    type: string,
    title: string,
    message: string,
    onclick?: any) => {

    switch (type) {
        case 'success':
            notification.success({
                message: title,
                description: message,
                placement: 'topRight',
                duration: 2.5,
            });
            break;
        case "error":
            notification.error({
                message: title,
                description: message,
                placement: 'topRight',
                duration: 2.5,
            });
            break;
        case "warning":
            notification.warning({
                message: title,
                description: message,
                placement: 'topRight',
                duration: 2.5,
            });
            break;
        case "info":
            notification.info({
                message: title,
                description: message,
                placement: 'topRight',
                duration: 5,
                onClick: () => onclick()
            });
            break;
        default:
            break;
    }

};